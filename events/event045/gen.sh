lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.385145145145145 --fixed-mass2 30.27071071071071 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024355220.4954784 \
--gps-end-time 1024362420.4954784 \
--d-distr volume \
--min-distance 687.8139192991033e3 --max-distance 687.8339192991033e3 \
--l-distr fixed --longitude -54.656768798828125 --latitude -14.551637649536133 --i-distr uniform \
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
