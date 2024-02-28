
function! CtrlXA#localization#init(spelllang) abort
  if matchstr(a:spelllang, '^\a\a') ==# 'en'
    return
  endif

  " split and remove regions from spelllangs
  let langs = split(a:spelllang, ',')
  call map(langs, "matchstr(v:val, '^\\a\\a')")

  let LocalizedToggles = []

  " if index(langs, 'en') >= 0
  "   let LocalizedToggles += [
  "         \ ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve'],
  "         \ ['Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve'],
  "         \ ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth'],
  "         \ ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth', 'Ninth', 'Tenth', 'Eleventh', 'Twelfth'],
  "         \
  "         \ ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
  "         \ ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  "         \ ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
  "         \ ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  "         \
  "         \ ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'],
  "         \ ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
  "         \ ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'],
  "         \ ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
  "         \]
  " endif
  if index(langs, 'zh') >= 0
    let LocalizedToggles += [
          \ ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'],
          \ ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'],
          \ ['第一', '第二', '第三', '第四', '第五', '第六', '第七', '第八', '第九', '第十', '第十一', '第十二'],
          \ ['第一', '第二', '第三', '第四', '第五', '第六', '第七', '第八', '第九', '第十', '第十一', '第十二'],
          \
          \ ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
          \ ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
          \ ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
          \ ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
          \
          \ ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
          \ ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
          \ ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
          \ ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
          \]
  endif
  if index(langs, 'ja') >= 0
    let LocalizedToggles += [
          \ ['ゼロ', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'],
          \ ['ゼロ', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'],
          \ ['第一', '第二', '第三', '第四', '第五', '第六', '第七', '第八', '第九', '第十', '第十一', '第十二'],
          \ ['第一', '第二', '第三', '第四', '第五', '第六', '第七', '第八', '第九', '第十', '第十一', '第十二'],
          \
          \ ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          \ ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          \ ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          \ ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          \
          \ ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
          \ ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
          \ ['日', '月', '火', '水', '木', '金', '土'],
          \ ['日', '月', '火', '水', '木', '金', '土'],
          \]
  endif
  if index(langs, 'es') >= 0
    let LocalizedToggles += [
          \ ['cero', 'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve', 'diez', 'once', 'doce'],
          \ ['Cero', 'Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco', 'Seis', 'Siete', 'Ocho', 'Nueve', 'Diez', 'Once', 'Doce'],
          \ ['primero', 'segundo', 'tercero', 'cuarto', 'quinto', 'sexto', 'séptimo', 'octavo', 'noveno', 'décimo', 'decimoprimero', 'decimosegundo'],
          \ ['Primero', 'Segundo', 'Tercero', 'Cuarto', 'Quinto', 'Sexto', 'Séptimo', 'Octavo', 'Noveno', 'Décimo', 'Decimoprimero', 'Decimosegundo'],
          \
          \ ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'],
          \ ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
          \ ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'],
          \ ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
          \
          \ ['domingo', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado'],
          \ ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
          \ ['dom', 'lun', 'mar', 'mié', 'jue', 'vie', 'sáb'],
          \ ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
          \]
  endif
  if index(langs, 'pt') >= 0
    let LocalizedToggles += [
          \ ['zero', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove', 'dez', 'onze', 'doze'],
          \ ['Zero', 'Um', 'Dois', 'Três', 'Quatro', 'Cinco', 'Seis', 'Sete', 'Oito', 'Nove', 'Dez', 'Onze', 'Doze'],
          \ ['primeiro', 'segundo', 'terceiro', 'quarto', 'quinto', 'sexto', 'sétimo', 'oitavo', 'nono', 'décimo', 'undécimo', 'duodécimo'],
          \ ['Primeiro', 'Segundo', 'Terceiro', 'Quarto', 'Quinto', 'Sexto', 'Sétimo', 'Oitavo', 'Nono', 'Décimo', 'Undécimo', 'Duodécimo'],
          \
          \ ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'],
          \ ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
          \ ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'],
          \ ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
          \
          \ ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'],
          \ ['domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sábado'],
          \ ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'],
          \ ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
          \ ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'],
          \ ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
          \]
  endif
  if index(langs, 'fr') >= 0
    let LocalizedToggles += [
          \ ['zéro', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf', 'dix', 'onze', 'douze'],
          \ ['Zéro', 'Un', 'Deux', 'Trois', 'Quatre', 'Cinq', 'Six', 'Sept', 'Huit', 'Neuf', 'Dix', 'Onze', 'Douze'],
          \ ['premier', 'deuxième', 'troisième', 'quatrième', 'cinquième', 'sixième', 'septième', 'huitième', 'neuvième', 'dixième', 'onzième', 'douzième'],
          \ ['Premier', 'Deuxième', 'Troisième', 'Quatrième', 'Cinquième', 'Sixième', 'Septième', 'Huitième', 'Neuvième', 'Dixième', 'Onzième', 'Douzième'],
          \
          \ ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'],
          \ ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
          \ ['jan', 'fév', 'mar', 'avr', 'mai', 'jun', 'jul', 'aoû', 'sep', 'oct', 'nov', 'déc'],
          \ ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'],
          \
          \ ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],
          \ ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
          \ ['dim', 'lun', 'mar', 'mer', 'jeu', 'ven', 'sam'],
          \ ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
          \]
  endif
  if index(langs, 'it') >= 0
    let LocalizedToggles += [
          \ ['zero', 'uno', 'due', 'tre', 'quattro', 'cinque', 'sei', 'sette', 'otto', 'nove', 'dieci', 'undici', 'dodici'],
          \ ['Zero', 'Uno', 'Due', 'Tre', 'Quattro', 'Cinque', 'Sei', 'Sette', 'Otto', 'Nove', 'Dieci', 'Undici', 'Dodici'],
          \ ['primo', 'secondo', 'terzo', 'quarto', 'quinto', 'sesto', 'settimo', 'ottavo', 'nono', 'decimo', 'undicesimo', 'dodicesimo'],
          \ ['Primo', 'Secondo', 'Terzo', 'Quarto', 'Quinto', 'Sesto', 'Settimo', 'Ottavo', 'Nono', 'Decimo', 'Undicesimo', 'Dodicesimo'],
          \
          \ ['gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno', 'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre'],
          \ ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
          \ ['gen', 'feb', 'mar', 'apr', 'mag', 'giu', 'lug', 'ago', 'set', 'ott', 'nov', 'dic'],
          \ ['Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu', 'Lug', 'Ago', 'Set', 'Ott', 'Nov', 'Dic'],
          \
          \ ['domenica', 'lunedì', 'martedì', 'mercoledì', 'giovedì', 'venerdì', 'sabato'],
          \ ['Domenica', 'Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato'],
          \ ['dom', 'lun', 'mar', 'mer', 'gio', 'ven', 'sab'],
          \ ['Dom', 'Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab'],
          \]
  endif
  if index(langs, 'de') >= 0
    let LocalizedToggles += [
          \ ['null', 'eins', 'zwei', 'drei', 'vier', 'fünf', 'sechs', 'sieben', 'acht', 'neun', 'zehn', 'elf', 'zwölf'],
          \ ['Null', 'Eins', 'Zwei', 'Drei', 'Vier', 'Fünf', 'Sechs', 'Sieben', 'Acht', 'Neun', 'Zehn', 'Elf', 'Zwölf'],
          \ ['erster', 'zweiter', 'dritter', 'vierter', 'fünfter', 'sechster', 'siebter', 'achter', 'neunter', 'zehnter', 'elfter', 'zwölfter'],
          \ ['Erster', 'Zweiter', 'Dritter', 'Vierter', 'Fünfter', 'Sechster', 'Siebter', 'Achter', 'Neunter', 'Zehnter', 'Elfter', 'Zwölfter'],
          \
          \ ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
          \ ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
          \ ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez'],
          \ ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez'],
          \
          \ ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'],
          \ ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'],
          \ ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
          \ ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
          \]
  endif
  if index(langs, 'nl') >= 0
    let LocalizedToggles += [
          \ ['nul', 'een', 'twee', 'drie', 'vier', 'vijf', 'zes', 'zeven', 'acht', 'negen', 'tien', 'elf', 'twaalf'],
          \ ['Nul', 'Een', 'Twee', 'Drie', 'Vier', 'Vijf', 'Zes', 'Zeven', 'Acht', 'Negen', 'Tien', 'Elf', 'Twaalf'],
          \ ['eerste', 'tweede', 'derde', 'vierde', 'vijfde', 'zesde', 'zevende', 'achtste', 'negende', 'tiende', 'elfde', 'twaalfde'],
          \ ['Eerste', 'Tweede', 'Derde', 'Vierde', 'Vijfde', 'Zesde', 'Zevende', 'Achtste', 'Negende', 'Tiende', 'Elfde', 'Twaalfde'],
          \
          \ ['januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december'],
          \ ['Januari', 'Februari', 'Maart', 'April', 'Mei', 'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November', 'December'],
          \ ['jan', 'feb', 'mrt', 'apr', 'mei', 'jun', 'jul', 'aug', 'sep', 'okt', 'nov', 'dec'],
          \ ['Jan', 'Feb', 'Mrt', 'Apr', 'Mei', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec'],
          \
          \ ['zondag', 'maandag', 'dinsdag', 'woensdag', 'donderdag', 'vrijdag', 'zaterdag'],
          \ ['Zondag', 'Maandag', 'Dinsdag', 'Woensdag', 'Donderdag', 'Vrijdag', 'Zaterdag'],
          \ ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'],
          \ ['Zo', 'Ma', 'Di', 'Wo', 'Do', 'Vr', 'Za'],
          \]
  endif
  if index(langs, 'ru') >= 0
    let LocalizedToggles += [
        \ ['ноль', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять', 'десять', 'одиннадцать', 'двенадцать'],
        \ ['Ноль', 'Один', 'Два', 'Три', 'Четыре', 'Пять', 'Шесть', 'Семь', 'Восемь', 'Девять', 'Десять', 'Одиннадцать', 'Двенадцать'],
        \ ['первый', 'второй', 'третий', 'четвертый', 'пятый', 'шестой', 'седьмой', 'восьмой', 'девятый', 'десятый', 'одиннадцатый', 'двенадцатый'],
        \ ['Первый', 'Второй', 'Третий', 'Четвертый', 'Пятый', 'Шестой', 'Седьмой', 'Восьмой', 'Девятый', 'Десятый', 'Одиннадцатый', 'Двенадцатый'],
        \
        \ ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь'],
        \ ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
        \ ['янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'],
        \ ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
        \
        \ ['воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота'],
        \ ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
        \ ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб'],
        \ ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
  endif
  if index(langs, 'pl') >= 0
    let LocalizedToggles += [
          \ ['zero', 'jeden', 'dwa', 'trzy', 'cztery', 'pięć', 'sześć', 'siedem', 'osiem', 'dziewięć', 'dziesięć', 'jedenaście', 'dwanaście'],
          \ ['Zero', 'Jeden', 'Dwa', 'Trzy', 'Cztery', 'Pięć', 'Sześć', 'Siedem', 'Osiem', 'Dziewięć', 'Dziesięć', 'Jedenaście', 'Dwanaście'],
          \ ['pierwszy', 'drugi', 'trzeci', 'czwarty', 'piąty', 'szósty', 'siódmy', 'ósmy', 'dziewiąty', 'dziesiąty', 'jedenasty', 'dwunasty'],
          \ ['Pierwszy', 'Drugi', 'Trzeci', 'Czwarty', 'Piąty', 'Szósty', 'Siódmy', 'Ósmy', 'Dziewiąty', 'Dziesiąty', 'Jedenasty', 'Dwunasty'],
          \
          \ ['styczeń', 'luty', 'marzec', 'kwiecień', 'maj', 'czerwiec', 'lipiec', 'sierpień', 'wrzesień', 'październik', 'listopad', 'grudzień'],
          \ ['Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'],
          \ ['sty', 'lut', 'mar', 'kwi', 'maj', 'cze', 'lip', 'sie', 'wrz', 'paź', 'lis', 'gru'],
          \ ['Sty', 'Lut', 'Mar', 'Kwi', 'Maj', 'Cze', 'Lip', 'Sie', 'Wrz', 'Paź', 'Lis', 'Gru'],
          \
          \ ['niedziela', 'poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota'],
          \ ['Niedziela', 'Poniedziałek', 'Wtorek', 'Środa', 'Czwartek', 'Piątek', 'Sobota'],
          \ ['nd', 'pn', 'wt', 'śr', 'czw', 'pt', 'sb'],
          \ ['Nd', 'Pn', 'Wt', 'Śr', 'Czw', 'Pt', 'Sb'],
          \]
  endif
  if index(langs, 'ro') >= 0
    let LocalizedToggles += [
          \ ['zero', 'unu', 'doi', 'trei', 'patru', 'cinci', 'șase', 'șapte', 'opt', 'nouă', 'zece', 'unsprezece', 'doisprezece'],
          \ ['Zero', 'Unu', 'Doi', 'Trei', 'Patru', 'Cinci', 'Șase', 'Șapte', 'Opt', 'Nouă', 'Zece', 'Unsprezece', 'Doisprezece'],
          \ ['primul', doilea', 'treilea', 'patrulea', 'cincilea', 'șaselea', 'șaptelea', 'optulea', 'nouălea', 'zecelea', 'unsprezecelea', 'doisprezecelea'],
          \ ['Primul', 'doilea', 'treilea', 'patrulea', 'cincilea', 'șaselea', 'șaptelea', 'optulea', 'nouălea', 'zecelea', 'unsprezecelea', 'doisprezecelea'],
          \
          \ ['ianuarie', 'februarie', 'martie', 'aprilie', 'mai', 'iunie', 'iulie', 'august', 'septembrie', 'octombrie', 'noiembrie', 'decembrie'],
          \ ['Ianuarie', 'Februarie', 'Martie', 'Aprilie', 'Mai', 'Iunie', 'Iulie', 'August', 'Septembrie', 'Octombrie', 'Noiembrie', 'Decembrie'],
          \ ['ian', 'feb', 'mar', 'apr', 'mai', 'iun', 'iul', 'aug', 'sep', 'oct', 'nov', 'dec'],
          \ ['Ian', 'Feb', 'Mar', 'Apr', 'Mai', 'Iun', 'Iul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
          \
          \ ['duminică', 'luni', 'marți', 'miercuri', 'joi', 'vineri', 'sâmbătă'],
          \ ['Duminică', 'Luni', 'Marți', 'Miercuri', 'Joi', 'Vineri', 'Sâmbătă'],
          \ ['dum', 'lun', 'mar', 'mie', 'joi', 'vin', 'sâm'],
          \ ['Dum', 'Lun', 'Mar', 'Mie', 'Joi', 'Vin', 'Sâm'],
          \]
  endif

  let b:CtrlXA_Toggles = LocalizedToggles + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
endf
