export SPARK_HOME=/data/spark
$SPARK_HOME/bin/spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.6 /home/workspace/jobs/sparkpykafkajoin.py | tee /home/workspace/logs/kafkajoin.log 
