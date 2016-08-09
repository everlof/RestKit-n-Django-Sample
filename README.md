# RestKit-n-Django-Sample

This is a project created as a playground to become more familiar various frameworks. Primarily the following:
 * RestKit
 * Django
 * Django REST Framework

I've been using:
 * Python 3.4
 * Xcode 7.3.1 (Swift 1.2)
 * Check `requirement.txt` to find out exactly which django versions.
 * Check `Podfile.lock` to find out exactly which iOS library versions.

Get stuff up and running:
 1. Create the virtual environment
 2. Clone this repo
 3. Run the django server
 4. Run the iOS app

Get stuff up and running _detailed_:
```bash
# Create a virtual environment
python -m venv venv

# cd to the virtual environment
cd venv

# Clone this repo
git clone https://github.com/everlof/RestKit-n-Django-Sample.git

# Activate the virtual environment
. bin/activate

# cd to the repoo
cd RestKit-n-Django-Sample/

# Install requirements
pip install -r requirement.txt

# Apply migrations
python manage.py migrate

# Run the server
python manage.py runserver

# Create a user
curl -XPOST http://127.0.0.1:8000/users/register \
-d '{"username":"tester","password":"tester","email":"test@test.com"}' \
-H "Content-Type: application/json"

# Use the app and log in with tester/tester!
```
