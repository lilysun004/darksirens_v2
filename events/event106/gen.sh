lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.89189189189189 --fixed-mass2 85.15147147147148 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002833088.6943581 \
--gps-end-time 1002840288.6943581 \
--d-distr volume \
--min-distance 3368.641229462444e3 --max-distance 3368.661229462444e3 \
--l-distr fixed --longitude -151.71646118164062 --latitude 22.985883712768555 --i-distr uniform \
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
