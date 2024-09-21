lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.957637637637639 --fixed-mass2 76.32684684684685 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020624754.5017976 \
--gps-end-time 1020631954.5017976 \
--d-distr volume \
--min-distance 689.5095330193632e3 --max-distance 689.5295330193632e3 \
--l-distr fixed --longitude 99.49276733398438 --latitude 32.56136703491211 --i-distr uniform \
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
