lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.048968968968969 --fixed-mass2 51.28172172172172 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007799794.8597276 \
--gps-end-time 1007806994.8597276 \
--d-distr volume \
--min-distance 901.976503349597e3 --max-distance 901.996503349597e3 \
--l-distr fixed --longitude 127.13884735107422 --latitude 31.106548309326172 --i-distr uniform \
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
