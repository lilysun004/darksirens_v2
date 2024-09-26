lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.73481481481482 --fixed-mass2 80.27691691691692 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000311819.9700241 \
--gps-end-time 1000319019.9700241 \
--d-distr volume \
--min-distance 4098.506496970551e3 --max-distance 4098.526496970551e3 \
--l-distr fixed --longitude -110.95210266113281 --latitude -11.123757362365723 --i-distr uniform \
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
