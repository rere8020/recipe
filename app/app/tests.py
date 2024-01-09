from django.test import SimpleTestCase
from app import calc

class MyTests(SimpleTestCase):
    def test_add(self):
        result = calc.add(5, 6)
        self.assertEqual(result, 1)