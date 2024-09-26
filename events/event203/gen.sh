lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.58858858858859 --fixed-mass2 35.48144144144145 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005610533.5405464 \
--gps-end-time 1005617733.5405464 \
--d-distr volume \
--min-distance 463.4093951793355e3 --max-distance 463.4293951793355e3 \
--l-distr fixed --longitude 105.37237548828125 --latitude -68.32511901855469 --i-distr uniform \
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
