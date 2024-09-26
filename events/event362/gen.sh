lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.245125125125124 --fixed-mass2 54.72752752752753 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006240727.2360013 \
--gps-end-time 1006247927.2360013 \
--d-distr volume \
--min-distance 3102.4386821193275e3 --max-distance 3102.458682119328e3 \
--l-distr fixed --longitude -106.07647705078125 --latitude 79.09778594970703 --i-distr uniform \
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
