import pytest
import datetime
import edina_garbage.schedule as schedule
from edina_garbage.schedule import PickUpWeek


@pytest.mark.parametrize(
    'pickup_date, expected', [
        (datetime.date(2020, 4, 14), schedule.PickUpWeek.BLUE),
        (datetime.date(2020, 4, 7), schedule.PickUpWeek.GREY),
        (datetime.date(2020, 9, 16), schedule.PickUpWeek.BLUE),
        (datetime.date(2020, 12, 2), schedule.PickUpWeek.GREY),
    ]
)
def test_color_of_week(pickup_date, expected):
    color = schedule.get_color_for_day(pickup_date)
    assert color == expected


def test_color_of_week_not_before_jan_2020():
    dec_2019 = datetime.date(2019, 12, 31)

    with pytest.raises(ValueError) as ve:
        schedule.get_color_for_day(dec_2019)
        assert str(ve) == ""


def test_flips_color():
    assert PickUpWeek.BLUE.flip() == PickUpWeek.GREY
