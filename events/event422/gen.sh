lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 53.80304304304305 --fixed-mass2 79.60456456456457 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007879005.8206646 \
--gps-end-time 1007886205.8206646 \
--d-distr volume \
--min-distance 2682.1075004647005e3 --max-distance 2682.127500464701e3 \
--l-distr fixed --longitude -134.95095825195312 --latitude -27.521120071411133 --i-distr uniform \
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
