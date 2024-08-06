lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.83591591591592 --fixed-mass2 47.66782782782783 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017692299.3743397 \
--gps-end-time 1017699499.3743397 \
--d-distr volume \
--min-distance 1738.9604869482637e3 --max-distance 1738.9804869482637e3 \
--l-distr fixed --longitude -72.4501953125 --latitude -39.622493743896484 --i-distr uniform \
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
