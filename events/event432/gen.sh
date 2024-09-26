lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.73961961961962 --fixed-mass2 78.84816816816817 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006453653.7708629 \
--gps-end-time 1006460853.7708629 \
--d-distr volume \
--min-distance 487.1740849298042e3 --max-distance 487.1940849298042e3 \
--l-distr fixed --longitude 89.77946472167969 --latitude -31.364765167236328 --i-distr uniform \
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
