# Makefile pour aescrypt aescrypt_keygen et aeserase
# make all clean, pour n'avoir que les éxécutables 

all : aescrypt aeserase pwgen

aescrypt : aescrypt.o aes.o sha256.o password.o keyfile.o
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -liconv -o aescrypt aescrypt.o aes.o sha256.o password.o keyfile.o

aeserase : aeserase.o
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -liconv -o Aeserase aeserase.o 

pwgen : pwgen.o
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -liconv -o pwgen pwgen.o

#########################
# construction aescrypt #
#########################

aescrypt.o : aescrypt.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -c aescrypt.c
aes.o : aes.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -c aes.c
sha256.o : sha256.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -c sha256.c

password.o : password.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -c password.c
keyfile.o : keyfile.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64 -c keyfile.c

#########################
# construction Aeserase #
#########################

aeserase.o : aeserase.c 
	gcc -c aeserase.c 

######################
# construction pwgen #
######################

pwgen.o : pwgen.c
	gcc -Wall -Wextra -pedantic -std=c99 -D_FILE_OFFSET_BITS=64  -c pwgen.c

##########
# Autres #
##########

clean :
	rm -rf aescrypt.o aes.o sha256.o password.o keyfile.o aeserase.o pwgen.o 
        
mrproper : clean
	rm -rf aescrypt pwgen aeserase

test: aescrypt
	@$(CC) -DTEST -o sha.test sha256.c
	@./sha.test
	@rm sha.test
	@$(CC) -DTEST -o aes.test aes.c
	@./aes.test
	@rm aes.test
	# Encrypting and decrypting text files
	# Test zero-length file
	@cat /dev/null > test.orig.txt
	@./aescrypt -e -p "praxis" test.orig.txt
	@cp test.orig.txt.aes test.txt.aes
	@./aescrypt -d -p "praxis" test.txt.aes
	@cmp test.orig.txt test.txt
	@rm test.orig.txt test.orig.txt.aes test.txt.aes test.txt
	# Testing short file (one AES block)
	@echo "Testing..." > test.orig.txt
	@./aescrypt -e -p "praxis" test.orig.txt
	@cp test.orig.txt.aes test.txt.aes
	@./aescrypt -d -p "praxis" test.txt.aes
	@cmp test.orig.txt test.txt
	@rm test.orig.txt test.orig.txt.aes test.txt.aes test.txt
	# Test password length boundary
	# Test password length 0
	@cat /dev/null >test.passwd.txt
	@echo "Testing..." > test.txt
	@# Expecting a failure here, but reflect opposite result code
	@./aescrypt -e -p `cat test.passwd.txt` test.txt 2>/dev/null && \
	    echo Password length test failed && \
	    exit 1 || \
	    true
	@rm test.txt test.passwd.txt
	# Test password length 1023
	@cat /dev/null >test.passwd.txt
	@for x in `seq 1 1023`; do printf X >>test.passwd.txt; done
	@echo "Testing..." > test.txt
	@./aescrypt -e -p `cat test.passwd.txt` test.txt
	@rm test.txt.aes test.txt test.passwd.txt
	# Test password length 1024
	@cat /dev/null >test.passwd.txt
	@for x in `seq 1 1024`; do printf X >>test.passwd.txt; done
	@echo "Testing..." > test.txt
	@./aescrypt -e -p `cat test.passwd.txt` test.txt
	@rm test.txt.aes test.txt test.passwd.txt
	# Test password length 1025
	@cat /dev/null >test.passwd.txt
	@for x in `seq 1 1025`; do printf X >>test.passwd.txt; done
	@echo "Testing..." > test.txt
	@# Expecting a failure here, but reflect opposite result code
	@./aescrypt -e -p `cat test.passwd.txt` test.txt 2>/dev/null && \
	    echo Password length test failed && \
	    exit 1 || \
	    true
	@rm test.txt test.passwd.txt
	# Testing longer file
	@cat /dev/null >test.orig.txt
	@for i in `seq 1 50000`; do echo "This is a test" >>test.orig.txt; done
	@./aescrypt -e -p "praxis" test.orig.txt
	@cp test.orig.txt.aes test.txt.aes
	@./aescrypt -d -p "praxis" test.txt.aes
	@cmp test.orig.txt test.txt
	@rm test.orig.txt test.orig.txt.aes test.txt.aes test.txt
	@echo All file encryption tests passed
