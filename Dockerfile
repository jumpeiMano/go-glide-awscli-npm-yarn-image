FROM golang:1.9.2

RUN apt-get update
RUN apt-get install -y netcat \
                       python \
                       python-pip \
                       build-essential \
                       libpng-dev
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs
RUN npm rebuild node-sass --force
RUN pip install awscli
RUN curl https://glide.sh/get | sh
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN go get -u github.com/alecthomas/gometalinter
RUN gometalinter --install
RUN apt-get install -y rubygems
RUN gem install fakes3
RUN fakes3 -r /mnt/fakes3_root -p 4567 &
RUN aws --endpoint-url http://localhost:4567 s3 mb s3://test-bucket
