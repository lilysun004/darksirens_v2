lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.262182182182183 --fixed-mass2 57.41693693693694 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004979813.7374772 \
--gps-end-time 1004987013.7374772 \
--d-distr volume \
--min-distance 2278.4676234912436e3 --max-distance 2278.487623491244e3 \
--l-distr fixed --longitude 123.78482055664062 --latitude -22.98587417602539 --i-distr uniform \
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
