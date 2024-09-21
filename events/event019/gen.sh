lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.561761761761762 --fixed-mass2 82.63015015015016 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010148779.5447134 \
--gps-end-time 1010155979.5447134 \
--d-distr volume \
--min-distance 796.2346744160953e3 --max-distance 796.2546744160953e3 \
--l-distr fixed --longitude 78.01013946533203 --latitude -61.999935150146484 --i-distr uniform \
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
