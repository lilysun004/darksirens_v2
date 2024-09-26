lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.974694694694694 --fixed-mass2 8.755435435435436 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021256878.8066208 \
--gps-end-time 1021264078.8066208 \
--d-distr volume \
--min-distance 1050.7209654652295e3 --max-distance 1050.7409654652295e3 \
--l-distr fixed --longitude 87.14297485351562 --latitude 78.0525131225586 --i-distr uniform \
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
