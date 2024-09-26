lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.2962962962963 --fixed-mass2 56.07223223223224 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020261085.999648 \
--gps-end-time 1020268285.999648 \
--d-distr volume \
--min-distance 2096.560319995523e3 --max-distance 2096.5803199955235e3 \
--l-distr fixed --longitude -158.3133087158203 --latitude -22.102231979370117 --i-distr uniform \
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
