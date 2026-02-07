CC=gcc

all:	stb_image_write.h ceval.h vec.h hashmap.h \
	evaluation_2 evaluation_3 evaluation_4 evaluation_5 \
	evaluation_6 evaluation_7 evaluation_8 \
	vector_usage_1 vector_usage_2 vector_usage_3 \
	simple_image_1 simple_image_2 simple_image_3 simple_image_4 \
	hashmap_usage_1 hashmap_usage_2 hashmap_usage_3 \
	perlin_noise

clean:
	rm -f ceval.h
	rm -f stb_image_write.h
	rm -f vec.h
	rm -f hashmap.h
	rm -f evaluation_1 evaluation_2 evaluation_3 evaluation_4 evaluation_5
	rm -f evaluation_6 evaluation_7 evaluation_8
	rm -f vector_usage_1 vector_usage_2 vector_usage_3
	rm -f simple_image_1 simple_image_2 simple_image_3 simple_image_4
	rm -f hashmap_usage_1 hashmap_usage_2 hashmap_usage_3
	rm -f perlin_noise

evaluation_1:	evaluation_1.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_2:	evaluation_2.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_3:	evaluation_3.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_4:	evaluation_4.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_5:	evaluation_5.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_6:	evaluation_6.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_7:	evaluation_7.c ceval.h
	$(CC) -lm -O0 $< -o $@

evaluation_8:	evaluation_8.c ceval.h
	$(CC) -lm -O0 $< -o $@

hashmap_usage_1:	hashmap_usage_1.c vec.h
	$(CC) -O0 $< -o $@

hashmap_usage_2:	hashmap_usage_2.c vec.h
	$(CC) -O0 $< -o $@

hashmap_usage_3:	hashmap_usage_3.c vec.h
	$(CC) -O0 $< -o $@

vector_usage_1:	vector_usage_1.c vec.h
	$(CC) -O0 $< -o $@

vector_usage_2:	vector_usage_2.c vec.h
	$(CC) -O0 $< -o $@

vector_usage_3:	vector_usage_3.c vec.h
	$(CC) -O0 $< -o $@

simple_image_1:	simple_image_1.c stb_image_write.h
	$(CC) -O0 $< -o $@

simple_image_2:	simple_image_2.c stb_image_write.h
	$(CC) -O0 $< -o $@

simple_image_3:	simple_image_3.c stb_image_write.h
	$(CC) -O0 $< -o $@

simple_image_4:	simple_image_4.c stb_image_write.h
	$(CC) -O0 $< -o $@

perlin_noise:	perlin_noise.c
	$(CC) -O0 $< -o $@

stb_image_write.h:
	wget https://raw.githubusercontent.com/nothings/stb/refs/heads/master/stb_image_write.h

ceval.h:
	wget https://raw.githubusercontent.com/erstan/ceval-single-header/refs/heads/e_t/ceval.h

vec.h:
	wget https://raw.githubusercontent.com/OguzhanUmutlu/vec.h/refs/heads/main/vec.h

hashmap.h:
	wget https://raw.githubusercontent.com/sheredom/hashmap.h/refs/heads/master/hashmap.h
