"""
Command to wait for DB to be ready

"""
import time
from django.core.management.base import BaseCommand
from psycopg2 import OperationalError as PsycopgOpError
from django.db.utils import OperationalError


class Command(BaseCommand):
    def handle(self, *args, **options):
        self.stdout.write('Waiting for database...')
        db_up = False
        while db_up is False:
            try:
                self.check()
                db_up = True
            except (PsycopgOpError, OperationalError):
                self.stdout.write('Waiting 1 sec for database to be up...')
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS('Database is up.'))
