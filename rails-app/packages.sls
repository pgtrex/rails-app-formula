# Install pre-requisite packages


app_pkgs:
  pkg.installed:
    - names:
      - pdftk
      - libfontconfig
      - libfontconfig1
      - s3cmd

/srv/.s3cfg:
  file:
    - managed
    - source: salt://rails-app/files/app/config/s3cfg
    - user: {{ pillar['rails-app']['user'] }}
    - group: {{ pillar['rails-app']['user'] }}
    - mode: 0750
    - template: jinja
    - require:
      - pkg: s3cmd
      - user: {{ pillar['rails-app']['user'] }}



/usr/bin/wkhtmltopdf:
  file:
    - managed
    - source: salt://rails-app/files/app/bin/wkhtmltopdf-linux-amd64
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
