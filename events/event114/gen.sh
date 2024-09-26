lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.321881881881886 --fixed-mass2 73.30126126126126 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014866230.4428506 \
--gps-end-time 1014873430.4428506 \
--d-distr volume \
--min-distance 1874.3081385281992e3 --max-distance 1874.3281385281991e3 \
--l-distr fixed --longitude -141.2028350830078 --latitude 27.451622009277344 --i-distr uniform \
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
