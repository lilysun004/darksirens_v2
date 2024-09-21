lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 75.15023023023024 --fixed-mass2 57.753113113113116 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023772057.5501193 \
--gps-end-time 1023779257.5501193 \
--d-distr volume \
--min-distance 976.2379477693877e3 --max-distance 976.2579477693877e3 \
--l-distr fixed --longitude -177.21434020996094 --latitude 26.26603889465332 --i-distr uniform \
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
