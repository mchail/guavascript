--- 
title: Typewriter Dismantlement
date: 16/03/2013

Many years ago, I heard a question on the radio show "Wait, Wait, Don't Tell Me" that went something like this:

> What do these three words have in common?
>
> A. typewriter  
> B. prototype  
> C. puppeteer

If you guessed "Gepetto documenting Pinocchio's construction," I award you full points, but unfortunately that's not what NPR was looking for. The correct answer was, "Each word may be typed on a QWERTY keyboard using only the keys on the topmost row of letters." Neat, huh?

Every Unix-based computer (including Macs) comes with a file of dictionary words, used for spellchecking, located at `/usr/share/dict/words`. I used this file to answer the obvious question on your mind: "Is 'typewriter' the longest word I can type on the top row?" And while we're at it, why not answer a few equally-trivial questions? I've included the shell commands so you can run these yourself. Each command returns the top ten answers to its question, printing out each word preceded by its character count. Click a word to look it up.

## Using only the top row

    grep -P "^[qwertyuiop]+$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		rupturewort  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		proterotype  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		proprietory  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		typewriter  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		tetterwort  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		repetitory  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		repertoire  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		proprietor  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		pretorture  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		prerequire
  	</span>
  </li>
</ul>

## Using only the home row

    grep -iP "^[asdfghjkl]+$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		8
  	</span>
  	<span class="word">
  		galagala  
  	</span>
  </li>
  <li>
  	<span class="length">
  		8
  	</span>
  	<span class="word">
  		flagfall  
  	</span>
  </li>
  <li>
  	<span class="length">
  		8
  	</span>
  	<span class="word">
  		Haskalah  
  	</span>
  </li>
  <li>
  	<span class="length">
  		8
  	</span>
  	<span class="word">
  		Hadassah  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		shallal  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		halakah  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		haggada  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		dagassa  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		alfalfa  
  	</span>
  </li>
  <li>
  	<span class="length">
  		7
  	</span>
  	<span class="word">
  		Khalkha
  	</span>
  </li>
</ul>

## Using only the bottom row

This one isn't very exciting, but for completeness's sake...

    grep -iP "^[zxcvbnm]+$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		z  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		x  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		v  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		n  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		m  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		c  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		b  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		Z  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		X  
  	</span>
  </li>
  <li>
  	<span class="length">
  		1
  	</span>
  	<span class="word">
  		V
  	</span>
  </li>
</ul>

## Using only the left hand

    grep -iP "^[qwertasdfgzxcvb]+$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		tesseradecade  
  	</span>
  </li>
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		devertebrated  
  	</span>
  </li>
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		aftercataract  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		tessaradecad  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		terracewards  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		reasseverate  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		gazetteerage  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		westerwards  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		vertebrated  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		staggerweed
  	</span>
  </li>
</ul>

## Using only the right hand

    grep -iP "^[yuiophjklnm]+$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		phyllophyllin  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		miminypiminy  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		hypophyllium  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		polyphonium  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		hypophyllum  
  	</span>
  </li>
  <li>
  	<span class="length">
  		11
  	</span>
  	<span class="word">
  		hypolimnion  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		polyphylly  
  	</span>
  </li>
  <li>
  	<span class="length">
  		10
  	</span>
  	<span class="word">
  		Plynlymmon  
  	</span>
  </li>
  <li>
  	<span class="length">
  		9
  	</span>
  	<span class="word">
  		polyphyly  
  	</span>
  </li>
  <li>
  	<span class="length">
  		9
  	</span>
  	<span class="word">
  		polyphony
  	</span>
  </li>
</ul>

## Alternating hands for each letter

My personal favorite...these words are really fun to type.

    grep -iP "^[qwertasdfgzxcvb]?([yuiophjklnm][qwertasdfgzxcvb])+[yuiophjklnm]?$" /usr/share/dict/words | awk '{ print length(), $0 | "sort -nr" }' | head
<ul class="words">
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		dismantlement  
  	</span>
  </li>
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		autotoxicosis  
  	</span>
  </li>
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		antisudorific  
  	</span>
  </li>
  <li>
  	<span class="length">
  		13
  	</span>
  	<span class="word">
  		antiendowment  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		suspensorial  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		proamendment  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		leucocytotic  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		leucocytosis  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		chalcidiform  
  	</span>
  </li>
  <li>
  	<span class="length">
  		12
  	</span>
  	<span class="word">
  		autotoxicity
  	</span>
  </li>
</ul>

<div>
	<style type="text/css">
		ul.words {
			margin-top: 1em;
		}
		ul.words li {
			list-style: none;
		}	
		ul.words li .length {
			width: 30px;
			display: inline-block;
		}
		code {
			background: #ffffff;
			padding: 4px;
			border-radius: 6px;
			border: 1px solid #666;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.word').each(function(index, el) {
				var word = $(el).text().trim();
				$(el).html(
					$('<a></a>').attr('href', 'http://www.google.com/search?q=' + word).text(word).attr('target', '_blank')
				);
			});
		});
	</script>
</div>
