FROM ubuntu

COPY start.sh /start.sh

RUN dpkg --add-architecture i386 \
    && apt-get -y install wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y xvfb git curl default-jre openjdk-7-jre google-chrome-stable firefox php5 php5-curl \
    && git clone https://github.com/bogdananton/Selenium-Setup \
    && cd Selenium-Setup \
    && wget https://getcomposer.org/composer.phar \
    && php composer.phar install \
    && export DISPLAY=:99.0 \
    && /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16 \
    && chmod +x /start.sh

EXPOSE 4444
