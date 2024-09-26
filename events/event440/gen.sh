lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.974694694694694 --fixed-mass2 49.76892892892893 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026299079.8811982 \
--gps-end-time 1026306279.8811982 \
--d-distr volume \
--min-distance 1799.9621058289897e3 --max-distance 1799.9821058289897e3 \
--l-distr fixed --longitude 96.19886016845703 --latitude 22.128934860229492 --i-distr uniform \
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
