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
