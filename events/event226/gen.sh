lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.656816816816818 --fixed-mass2 28.84196196196196 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024031983.4433343 \
--gps-end-time 1024039183.4433343 \
--d-distr volume \
--min-distance 492.6420689357985e3 --max-distance 492.66206893579846e3 \
--l-distr fixed --longitude 86.71797180175781 --latitude -31.28040885925293 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
