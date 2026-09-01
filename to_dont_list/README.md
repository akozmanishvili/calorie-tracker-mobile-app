# to_dont_list

Amiko's to dont list App.

## Test fixes

### 1st Test

1st test fix - abbreviation test fail: test was expecting a, but was getting substring(0,2) which is ad and thats the reason it was failing

### 2nd Test

2nd test fix - test is expecting circleAvatar's child to be Text with abbreviaton t, but in to_do_item.dart circleAvatar's child wasn't a text nor abbreviaton. Set circleAvatar's child to Text with item.abbrev() value.

In addition, 2nd test was expecting black54:
(expect(circ.backgroundColor, Colors.black54);)
while circleAvatar's backgroundColor, if completed was true, was set to just "black" instead of "black54", fixed this and now test is successful

### 3rd Test

3rd test fix - buttons were placed incorrectly, CancelButton was placed where
adding happens, adding button where placed where cancelling happens. Swapped the places for OKButton with CancelButton, and names OK with Cancel, so now logic follows the labels

In addition, in main.dart in \_handleNewItem item was always constant with literal string value of "itemText". That is why nothing new showed up when typing. I removed const and put itemText parameter instead of literal string value "itemText"

## Result

After all of these fixes, all of the test runs are checked as green.
