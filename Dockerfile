FROM ubuntu

COPY . /code/
WORKDIR /code

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y python3-pip curl git \
    && apt-get install flex bison phantomjs \
    && apt-get autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && python3 -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host tsinghua.edu.cn \
    && cp config.template config

EXPOSE 5000
CMD ["python3", "cobra.py", "-H", "0.0.0.0", "-P", "5000"]
