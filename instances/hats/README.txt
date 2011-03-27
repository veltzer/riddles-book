The riddle goes like this:

N people are in a group.
They would be gathered in a hall and hats of N different colors are placed on their heads.
It could be that not all N colors would be used.
No one sees the hat on their own head.
Everyone sees the hats on all the rest of the peoples heads.
Each people has a number and knows his/her own number and the number of every other person
(you can think of it as if the numbers are printed on their T shirts...).
They can co-ordinate their stategy before the hall meeting.
They can not talk nor exchange information in any way at the meeting itself.

Could you co-ordinate a strategy so that whenever the hall meeting is held and whatever the
hat distribution on their head turns out to be, at least one of them will always correctly
guess the hat on his/her own head ?

Solution:
=========
For 1 person the issue is easy since there is only one color.
For 2 persons the table of all distributions of hats is such:
	0 0
	0 1
	1 0
	1 1
If person 0 always guesses whatever he sees and person 1 always guesses the reverse then one of
them will always be right:

	Person 0: guessing whatever is on the head of person 1
	Person 1: guessing the reverse of what is on the head of person 0.

	Person 0	Person 1	Person 1	Person 2	How many are right
	Wearing		Wearing		guesses		guesses
	0		0		0		1		1
	0		1		1		1		1
	1		0		0		0		1
	1		1		1		0		1

Can we enlarge this method to the 3 or N case ?

lets denote k=sum_of_all_hats % num_people.

Each person with index i will guess: (i-sum_that_i_sees) % num_people.

The k person will guess:
	(k-sum_that_k_sees) % num_people =
	(k-sum_of_all_hats-hat_k) % num_people =
	(k-k-hat_k) % num_people =
	hat_k % num_people =
	hat_k

* You may be tempted to say that every two people will guess differently but this is not the
case since the expression for the guess has two variables in it: the partial sum and the index.
They could compensate each other and thus make two different players guess the same guess.

* The statement that is true is that the distance between each guesser and the hat on his
head is unique. How do we prove that? Let assume that some of the people have distance d
from the hat on their head. This means that for those people:

(i-sum_that_i_sees) % num_people - hat_i = d

which means:
(i-sum_that_i_sees-hat_i) % num_people = d

which means:
(i-sum_of_all_hats) % num_people = d

which means:
i-k % num_people = d

which means:
i=d+k

This means that only the person with index d+k will be in distance d from the hat that he has.

(this is also demonstrated in the script).

* From the above statement it means that only one person is right at every iteration. This is very important but can also be derived from counting considerations since if two were right then
we could use this fact to switch hats and create a situation where no one was right (HOW?!?).

* Another statement which is left unproven is that this is the ONLY solution to this riddle which means that there is no other function that could achieve the same goal. This could be checked using a computer software that would work through all possible functions (there is a finite number of them after all...).
