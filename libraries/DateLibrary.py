import pytz
from datetime import datetime, timedelta
import platform


def getCurrentTime():
    get_current_os = platform.system()
    if get_current_os == 'Windows':
        paris_tz = pytz.timezone("Europe/Paris")
        now = datetime.now(paris_tz)
        currentTimeDate = now - timedelta(hours=1)
        date_format = '%Y-%m-%dT%H:%M:%S'
        formatted_date = currentTimeDate.strftime(date_format)
        date_of_Paris = formatted_date + '.000Z'
        return date_of_Paris
    else:
        paris_tz = pytz.timezone("Europe/Paris")
        now = datetime.now(paris_tz)
        currentTimeDate = now - timedelta(hours=1)
        date_format = '%Y-%m-%dT%H:%M:%S'
        formatted_date = currentTimeDate.strftime(date_format)
        date_of_Paris = formatted_date + '.000Z'
        return date_of_Paris
