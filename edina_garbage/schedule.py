import enum
import datetime
'''functions and classes dealing with pick up schedule'''


class PickUpWeek(enum.Enum):
    '''
    Which pick up week
    see: [Edina waste schedule](https://www.edinamn.gov/225/Pick-Up-Schedules)
    '''
    GREY = 0
    BLUE = 1

    def flip(self):
        '''return the opposite color'''
        if self == PickUpWeek.GREY:
            return PickUpWeek.BLUE
        else:
            return PickUpWeek.GREY


def get_color_for_day(pickup_date: datetime.date):
    '''
    Given a day, find out if it's GREY or BLUE

    pickup_date: the date you want to find the delivery color of
    '''

    # pick a recent week to start with
    start_date = datetime.date(2020, 1, 6)
    if pickup_date < start_date:
        raise ValueError('Date is too far in the past, pick a future date')

    color = PickUpWeek.GREY
    time_diff = datetime.timedelta(days=7)

    while start_date < pickup_date:
        start_date = start_date + time_diff
        color = color.flip()

    return color
