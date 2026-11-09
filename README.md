# udacity-data-streaming

Hai project của khóa **Udacity Data Streaming Nanodegree**.

| Project | Stack | Mô tả |
|---|---|---|
| [optimizing-public-transportation](optimizing-public-transportation/) | Kafka, Avro/Schema Registry, Kafka Connect (JDBC), REST Proxy, Faust, KSQL, Tornado | Pipeline streaming mô phỏng tàu điện CTA Chicago và hiển thị trạng thái realtime |
| [evaluate-human-balance](evaluate-human-balance/) | Kafka, Redis (Kafka source), Spark Structured Streaming | Join sự kiện rủi ro té ngã (STEDI) với dữ liệu khách hàng, đẩy vào topic cho dashboard |

Cả hai chạy trong **Udacity workspace** (đường dẫn `/home/workspace/...`, Kafka/Postgres/Redis/Spark cài sẵn), nên không chạy trực tiếp trên máy local nếu chưa tự dựng các service.
