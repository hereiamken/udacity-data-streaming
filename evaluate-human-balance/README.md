# Evaluate Human Balance (STEDI)

Ứng dụng STEDI đo cân bằng của người cao tuổi. Redis (qua Kafka Connect source) phát thông tin khách hàng vào topic `redis-server`; ứng dụng phát điểm rủi ro vào `stedi-events`. Spark Structured Streaming join hai luồng theo email và ghi ra topic `stedi-score` để vẽ biểu đồ.

```
Redis ─► Kafka Connect ─► redis-server ─┐
                                        ├─► Spark join (email) ─► stedi-score ─► STEDI graph
STEDI app ─────────────► stedi-events ──┘
```

## Cấu trúc

```
jobs/       # Spark jobs: events -> console, redis -> console, kafka join -> topic stedi-score
scripts/    # spark-submit wrappers (Spark 2.4.6 / Scala 2.11)
kafka/      # start Kafka Connect, Kafka REST, cấu hình connect-avro-standalone
redis/      # start Redis
startup/    # startup.sh: khởi động toàn bộ thành phần
stedi-application/  # application.conf (riskTopic=stedi-score), start/stop
docs/       # Guide.ipynb (đề bài), images, screenshots
```

## Chạy (trong workspace)

```bash
./startup/startup.sh
mkdir -p logs
./scripts/submit-event-kafkastreaming.sh     # kiểm tra stedi-events
./scripts/submit-redis-kafka-streaming.sh    # kiểm tra dữ liệu Redis
./scripts/submit-event-kafkajoin.sh          # job chính, ghi topic stedi-score
```
