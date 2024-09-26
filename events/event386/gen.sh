lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.04540540540541 --fixed-mass2 71.03207207207207 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028897510.1476166 \
--gps-end-time 1028904710.1476166 \
--d-distr volume \
--min-distance 2067.2925342617314e3 --max-distance 2067.312534261732e3 \
--l-distr fixed --longitude -90.64120483398438 --latitude 48.010501861572266 --i-distr uniform \
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
