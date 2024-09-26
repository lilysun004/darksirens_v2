lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.431511511511516 --fixed-mass2 59.93825825825826 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030376736.4374999 \
--gps-end-time 1030383936.4374999 \
--d-distr volume \
--min-distance 3811.9277759555184e3 --max-distance 3811.947775955519e3 \
--l-distr fixed --longitude -40.72918701171875 --latitude -21.246328353881836 --i-distr uniform \
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
