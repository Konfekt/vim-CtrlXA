if exists('g:CtrlXA_Toggles')
  finish
endif

scriptencoding utf-8

let g:CtrlXA_Toggles = [
  \ ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',      'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z'],
  \ ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',      'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'X', 'Y', 'Z'],
  \ ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix'],
  \ ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'],
  \
  \ ['alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta', 'eta', 'theta', 'iota', 'kappa', 'lambda', 'mu', 'nu', 'xi', 'omikron', 'pi', 'rho', 'sigma', 'tau', 'upsilon', 'phi', 'chi', 'psi', 'omega'],
  \ ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi', 'Omikron', 'Pi', 'Rho',  'Sigma', 'Tau', 'Upsilon', 'Phi', 'Chi', 'Psi', 'Omega'],
  \
  \ ['alfa', 'bravo', 'charlie',        , 'echo', 'foxtrot', 'golf', 'hotel', 'india', 'juliett', 'kilo', 'lima', 'mike',             'oscar', 'papa', 'quebec', 'romeo', 'sierra', 'tango', 'uniform', 'victor', 'whiskey', "x-ray", 'yankee', 'zulu'],
  \ ['Alfa', 'Bravo', 'Charlie',        , 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike',             'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango', 'Uniform', 'Victor', 'Whiskey', "X-ray", 'Yankee', 'Zulu'],
  \
  \ ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', '13th', '14th', '15th', '16th', '17th', '18th', '19th', '20th', '21st', '22nd', '23rd', '24th', '25th', '26th', '27th', '28th', '29th', '30th', '31st'],
  \
  \ ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve'],
  \ ['Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve'],
  \ ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth'],
  \ ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth', 'Ninth', 'Tenth', 'Eleventh', 'Twelfth'],
  \
  \ ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
  \ ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  \ ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
  \ ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  \
  \ ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'],
  \ ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
  \ ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'],
  \ ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
  \
  \ ['today', 'tomorrow', 'yesterday'], ['Today', 'Tomorrow', 'Yesterday'],
  \
  \ ['morning', 'noon', 'afternoon', 'evening'], ['Morning', 'Noon', 'Afternoon', 'Evening'],
  \
  \ ['day', 'night'], ['Day', 'Night'],
  \
  \ ['am', 'pm'], ['AM', 'PM'],
  \
  \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'],
  \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'],
  \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'],
  \ ['up', 'down'], ['Up', 'Down'] ,['UP', 'DOWN'],
  \ ['enable', 'disable'], ['Enable', 'Disable'],
  \ ['enabled', 'disabled'], ['Enabled', 'Disabled'],
  \ ['set', 'unset'],
  \ ['is', 'isnot'] ,
  \ ['&&', '||'],
  \ ['+', '-'], ['++', '--'],
  \ ['==', '!='] , ['=~', '!~'],
  \ ['<', '>'], ['<=', '>='], ['>>', '<<'],
  \
  \ ['int', 'float', 'double', 'char', 'string'],
  \ ['Int', 'Float', 'Double', 'Char', 'String'],
  \
  \ ['in', 'out'], ['In', 'Out'],
  \ ['input', 'output'], ['Input', 'Output'],
  \
  \ ['client', 'server'], ['Client', 'Server'],
  \
  \ ['success', 'failure'], ['Success', 'Failure'],
  \ ['successful', 'failed'], ['Successful', 'Failed'],
  \ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'],
  \
  \ ['remote', 'local', 'base'], ['REMOTE', 'LOCAL', 'BASE'],
  \ ['ours', 'theirs'],
  \ ['main', 'master', 'dev'],
  \
  \ ['accept', 'decline'], ['Accept', 'Decline'],
  \ ['add', 'remove'], ['Add', 'Remove'],
  \ ['allow', 'deny'], ['Allow', 'Deny'],
  \ ['buy', 'sell'], ['Buy', 'Sell'],
  \ ['close', 'open'], ['Close', 'Open'],
  \ ['compress', 'decompress'], ['Compress', 'Decompress'],
  \ ['create', 'destroy'], ['Create', 'Destroy'],
  \ ['enter', 'exit'], ['Enter', 'Exit'],
  \ ['expand', 'collapse'], ['Expand', 'Collapse'],
  \ ['fail', 'succeed'], ['Fail', 'Succeed'],
  \ ['import', 'export'], ['Import', 'Export'],
  \ ['increase', 'decrease'], ['Increase', 'Decrease'],
  \ ['join', 'leave'], ['Join', 'Leave'],
  \ ['lock', 'unlock'], ['Lock', 'Unlock'],
  \ ['push', 'pull'], ['Push', 'Pull'],
  \ ['read', 'write'], ['Read', 'Write'],
  \ ['receive', 'send'], ['Receive', 'Send'],
  \ ['save', 'discard'], ['Save', 'Discard'],
  \ ['show', 'hide'], ['Show', 'Hide'],
  \ ['start', 'stop'], ['Start', 'Stop'],
  \ ['win', 'lose'], ['Win', 'Lose'],
  \
  \ ['max', 'min'], ['Max', 'Min'],
  \ ['maximum', 'minimum'], ['Maximum', 'Minimum'],
  \ ['maximal', 'minimal'], ['Maximal', 'Minimal'],
  \ ['maximize', 'minimize'], ['Maximize', 'Minimize'],
  \
  \ ['upper', 'lower'], ['Upper', 'Lower'],
  \ ['top', 'bottom'], ['Top', 'Bottom'],
  \ ['above', 'below'], ['Above', 'Below'],
  \ ['forward', 'backward'], ['Forward', 'Backward'],
  \ ['right', 'middle', 'left'], ['Right', 'Middle', 'Left'],
  \ ['next', 'previous'], ['Next', 'Previous'],
  \ ['first', 'last'], ['First', 'Last'],
  \ ['begin', 'end'], ['Begin', 'End'],
  \ ['before', 'after'], ['Before', 'After'],
  \
  \ ['red', 'green', 'blue', 'black', 'white', 'gray', 'brown', 'yellow', 'orange', 'purple'],
  \ ['Red', 'Green', 'Blue', 'Black', 'White', 'Gray', 'Brown', 'Yellow', 'Orange', 'Purple'],
  \
  \ ['cyan', 'magenta', 'yellow'], ['Cyan', 'Magenta', 'Yellow'],
  \
  \ ['small', 'medium', 'large'], ['Small', 'Medium', 'Large'],
  \ ['hot', 'warm', 'cold'], ['Hot', 'Warm', 'Cold'],
  \
  \ ['few', 'many'], ['Few', 'Many'],
  \ ['much', 'little'], ['Much', 'Little'],
  \
  \ ['more', 'less'], ['More', 'Less'],
  \
  \ ['good', 'bad'], ['Good', 'Bad'],
  \ ['better', 'worse'], ['Better', 'Worse'],
  \ ['best', 'worst'], ['Best', 'Worst'],
  \
  \ ['bigger', 'smaller'], ['Bigger', 'Smaller'],
  \ ['cheap', 'expensive'], ['Cheap', 'Expensive'],
  \ ['clean', 'dirty'], ['Clean', 'Dirty'],
  \ ['clear', 'unclear'], ['Clear', 'Unclear'],
  \ ['detailed', 'brief'], ['Detailed', 'Brief'],
  \ ['early', 'late'], ['Early', 'Late'],
  \ ['easy', 'difficult'], ['Easy', 'Difficult'],
  \ ['fast', 'slow'], ['Fast', 'Slow'],
  \ ['gain', 'loss'], ['Gain', 'Loss'],
  \ ['high', 'low'], ['High', 'Low'],
  \ ['internal', 'external'], ['Internal', 'External'],
  \ ['light', 'dark'] , ['Light', 'Dark'] ,
  \ ['major', 'minor'], ['Major', 'Minor'],
  \ ['manual', 'automatic'], ['Manual', 'Automatic'],
  \ ['new', 'old'], ['New', 'Old'],
  \ ['normal', 'abnormal'], ['Normal', 'Abnormal'],
  \ ['now', 'later'], ['Now', 'Later'],
  \ ['optional', 'mandatory'], ['Optional', 'Mandatory'],
  \ ['permanent', 'temporary'], ['Permanent', 'Temporary'],
  \ ['private', 'public'], ['Private', 'Public'],
  \ ['quiet', 'loud'], ['Quiet', 'Loud'],
  \ ['rich', 'poor'], ['Rich', 'Poor'],
  \ ['simple', 'complex'], ['Simple', 'Complex'],
  \ ['strong', 'weak'], ['Strong', 'Weak'],
  \
  \ ['bit', 'byte', 'kilobyte', 'megabyte', 'gigabyte', 'terabyte'],
  \ ['Bit', 'Byte', 'Kilobyte', 'Megabyte', 'Gigabyte', 'Terabyte'],
  \
  \ ['MIT', 'GPL', 'Apache', 'BSD', 'LGPL', 'EPL', 'CC0', 'CC-BY', 'CC-BY-SA'],
  \
  \ ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS', 'HEAD'],
  \
  \ ['if', 'else', 'otherwise'],
  \
  \ ['zh', 'ja', 'en', 'es', 'pt', 'fr', 'it', 'de', 'nl', 'ro', 'ru', 'pl'],
  \
  \ ['north', 'east', 'south', 'west'], ['North', 'East', 'South', 'West'],
  \
  \ ['horizontal', 'vertical'], ['Horizontal', 'Vertical'],
\ ]
