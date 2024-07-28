FROM --platform=linux/amd64 prefecthq/prefect:2-latest

COPY . ./

RUN pip install -r requirements.txt
RUN pip install .

ENTRYPOINT ["prefect", "worker", "start", "--type", "volcano"]