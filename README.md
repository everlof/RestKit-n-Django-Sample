# RestKit-n-Django-Sample

This is a project created as a playground to become more familiar various frameworks. Primarily the following:
* RestKit
* Django
* Django REST Framework

I've been using:
1. Python 3.4
2. Xcode 7.3.1 (Swift 1.2)
3. Check `requirement.txt` to find out exactly which django versions.
4. Check `Podfile.lock` to find out exactly which iOS library versions.

Get stuff up and running:
1. Create the virtual environment
2. Clone this repo
3. Run the django server
4. Run the iOS app

Get stuff up and running _detailed_:
```bash
# Create a virtual environment
python -m venv venv
cd venv
git clone https://github.com/everlof/RestKit-n-Django-Sample.git
. bin/activate
cd RestKit-n-Django-Sample/
pip install -r requirement.txt

# Apply migrations
python manage.py migrate
python manage.py runserver

# Create a user
curl -XPOST http://127.0.0.1:8000/users/register \
-d '{"username":"tester","password":"tester","email":"test@test.com"}' \
-H "Content-Type: application/json"

```
