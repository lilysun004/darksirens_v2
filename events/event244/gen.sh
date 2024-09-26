lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 50.35723723723724 --fixed-mass2 81.53757757757758 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010141286.293015 \
--gps-end-time 1010148486.293015 \
--d-distr volume \
--min-distance 3232.007267667597e3 --max-distance 3232.0272676675972e3 \
--l-distr fixed --longitude -140.58901977539062 --latitude 22.99724006652832 --i-distr uniform \
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
