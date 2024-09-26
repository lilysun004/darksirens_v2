lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.673873873873873 --fixed-mass2 36.91019019019019 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003026705.7388165 \
--gps-end-time 1003033905.7388165 \
--d-distr volume \
--min-distance 3003.9766286083013e3 --max-distance 3003.9966286083018e3 \
--l-distr fixed --longitude 62.65003204345703 --latitude 40.6943244934082 --i-distr uniform \
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
