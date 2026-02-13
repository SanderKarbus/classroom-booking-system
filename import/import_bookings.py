import xml.etree.ElementTree as ET
import os
import psycopg2

DB_URL = os.getenv("DATABASE_URL")  # Supabase connection string

def get_text(node, tag):
    el = node.find(tag)
    return el.text.strip() if el is not None and el.text else None

def main():
    if not DB_URL:
        raise SystemExit("Set DATABASE_URL env var (Supabase/Postgres connection string).")

    tree = ET.parse("bookings.xml")
    root = tree.getroot()

    conn = psycopg2.connect(DB_URL)
    conn.autocommit = False
    cur = conn.cursor()

    for b in root.findall("booking"):
        classroom_name = get_text(b, "classroom_name")
        user_email = get_text(b, "user_email")
        lesson_type = get_text(b, "lesson_type")
        start_time = get_text(b, "start_time")
        end_time = get_text(b, "end_time")
        participants = int(get_text(b, "participants") or 0)

        cur.execute("select id from classrooms where name = %s", (classroom_name,))
        classroom = cur.fetchone()
        if not classroom:
            raise ValueError(f"Classroom not found: {classroom_name}")
        classroom_id = classroom[0]

        cur.execute("select id from users where email = %s", (user_email,))
        user = cur.fetchone()
        if not user:
            raise ValueError(f"User not found: {user_email}")
        user_id = user[0]

        cur.execute("select id from lesson_types where name = %s", (lesson_type,))
        lt = cur.fetchone()
        if not lt:
            # create lesson_type if missing
            cur.execute("insert into lesson_types (name) values (%s) returning id", (lesson_type,))
            lesson_type_id = cur.fetchone()[0]
        else:
            lesson_type_id = lt[0]

        cur.execute("""
            insert into bookings (classroom_id, user_id, lesson_type_id, start_time, end_time, participants)
            values (%s, %s, %s, %s, %s, %s)
        """, (classroom_id, user_id, lesson_type_id, start_time, end_time, participants))

    conn.commit()
    cur.close()
    conn.close()
    print("Imported bookings.xml successfully.")

if __name__ == "__main__":
    main()
