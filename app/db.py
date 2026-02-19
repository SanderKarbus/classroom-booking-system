import psycopg2

def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="classroom_booking",
        user="postgres",
        password="postgres"  # vajadusel muuda
    )
