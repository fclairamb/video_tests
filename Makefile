
FLAGS=-y -ss 11 -t 30
FLAGS_COMPRESS=-c:v libx265 -c:a aac -b:a 32k -ac 1 # -b:v 500k  -preset slow

FILES_SOEURS=soeur_unchanged.out.mov soeurs_x265.out.mp4 soeurs_x265_afftdn.out.mp4 soeurs_x265_rnnn_cb.out.mp4 soeurs_x265_rnnn_sh.out.mp4 soeurs_x265_anlmdn.out.mp4
FILES_MAMET=mamet_x265_rnnn_cb.out.mp4 mamet_x265_slow.out.mp4 mamet_x265_bw_500k.out.mp4 mamet_x265_bw_100k.out.mp4

all: $(FILES_SOEURS) $(FILES_MAMET)

clean:
	rm *.out.*

soeur_unchanged.out.mov: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) -c copy .tmp.$@ && mv .tmp.$@ $@

soeurs_x265.out.mp4: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) .tmp.$@ && mv .tmp.$@ $@

soeurs_x265_afftdn.out.mp4: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -af afftdn .tmp.$@ && mv .tmp.$@ $@

soeurs_x265_rnnn_cb.out.mp4: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -af arnndn=m=rnnn/cb.rnnn .tmp.$@ && mv .tmp.$@ $@

soeurs_x265_rnnn_sh.out.mp4: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -af arnndn=m=rnnn/sh.rnnn .tmp.$@ && mv .tmp.$@ $@

soeurs_x265_anlmdn.out.mp4: soeurs.in.mov
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -af anlmdn .tmp.$@ && mv .tmp.$@ $@

mamet_x265_rnnn_cb.out.mp4: mamet.in.mp4
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -af arnndn=m=rnnn/cb.rnnn .tmp.$@ && mv .tmp.$@ $@

mamet_x265_slow.out.mp4: mamet.in.mp4
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -preset slow .tmp.$@ && mv .tmp.$@ $@

mamet_x265_bw_500k.out.mp4: mamet.in.mp4
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -b:v 500k .tmp.$@ && mv .tmp.$@ $@

mamet_x265_bw_100k.out.mp4: mamet.in.mp4
	ffmpeg  -i $< $(FLAGS) $(FLAGS_COMPRESS) -b:v 100k .tmp.$@ && mv .tmp.$@ $@
