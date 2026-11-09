# Optimizing Public Transportation

Mô phỏng hệ thống tàu "L" của Chicago (CTA): producer sinh sự kiện, Kafka vận chuyển, các stream processor biến đổi, web server hiển thị.

```
 simulation.py ─► Station/Turnstile producers (Avro) ─► Kafka ─► KSQL (turnstile_summary) ─┐
               └► Weather producer (REST Proxy, Avro) ─► Kafka ──────────────────────────────┤
 Postgres(stations) ─► Kafka Connect JDBC ─► Faust (stations.table) ───────────────────────┤
                                                                                            ▼
                                                              consumers/server.py (Tornado :3000)
```

## Cấu trúc

```
producers/
  simulation.py          # điểm vào: vòng lặp thời gian mô phỏng
  connector.py           # đăng ký JDBC source connector (Postgres -> Kafka)
  models/                # Producer base, Line, Station, Train, Turnstile, Weather
  models/schemas/        # Avro schemas (key/value)
  data/                  # dữ liệu seed CTA
consumers/
  server.py              # điểm vào: Tornado web server + Kafka consumers
  consumer.py            # KafkaConsumer wrapper
  faust_stream.py        # Faust: Station -> TransformedStation
  ksql.py                # KSQL: turnstile -> turnstile_summary
  topic_check.py
  models/                # Lines, Line, Station, Weather (view model)
  templates/status.html
startup.sh, startup/     # khởi tạo service + Postgres trong Udacity workspace
```

## Chạy (trong workspace)

```bash
./startup.sh                                   # 1 lần: khởi động service, tạo DB
pip install -r producers/requirements.txt -r consumers/requirements.txt
cd producers && python simulation.py           # terminal 1
cd consumers && faust -A faust_stream worker -l info   # terminal 2
cd consumers && python ksql.py                 # terminal 3
cd consumers && python server.py               # terminal 4 -> http://localhost:3000
```

Python 3.7, các version trong `requirements.txt` đã cũ (confluent-kafka 1.1, pandas 0.24).

## Topic

Các lỗi runtime và tên topic không khớp đã được sửa; mọi topic dùng prefix `org.chicago.cta.*`.
