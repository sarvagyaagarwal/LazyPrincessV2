FROM python:3.10-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git -y

COPY requirements.txt /requirements.txt

RUN pip3 install -U pip && pip3 install -U -r /requirements.txt

ARG UPSTREAM_REPO
RUN if [ -z "$UPSTREAM_REPO" ]; then \
      echo "Cloning main Repository" && \
      git clone https://github.com/LazyDeveloperr/LazyPrincessV2 /LazyPrincessV2; \
    else \
      echo "Cloning Custom Repo from $UPSTREAM_REPO" && \
      git clone "$UPSTREAM_REPO" /LazyPrincessV2; \
    fi

WORKDIR /LazyPrincessV2

RUN pip3 install -U -r requirements.txt

CMD ["python3", "bot.py"]
