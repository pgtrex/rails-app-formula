# Setup unicorn
/etc/init/unicorn.conf:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/init/unicorn.conf
    - user: root
    - group: root
    - mode: 0744

/etc/sudoers.d/unicorn:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/sudoers.d/unicorn
    - user: root
    - group: root
    - mode: 0440

unicorn:
  service:
    - name: monit
    - running
    - enable: True
    - restart: True

/etc/monit/conf.d/unicorn:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/monit/conf.d/unicorn
    - user: root
    - group: root
    - mode: 0444

unicorn_monit_restart:
  service:
    - name: monit
    - running
    - enable: True
    - restart: True
    - require:
      - file: /etc/monit/conf.d/unicorn
    - watch:
      - file: /etc/monit/conf.d/unicorn

# Hack until we will get rbenv.do in upcomming saltstack version
'RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=2.1.2 rbenv exec gem install unicorn --version 4.8.2':
cmd.run:
- unless: 'RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=2.1.2 rbenv exec gem list | grep unicorn | grep 4.8.2'