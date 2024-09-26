lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.24760760760761 --fixed-mass2 78.00772772772773 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008713817.259387 \
--gps-end-time 1008721017.259387 \
--d-distr volume \
--min-distance 1890.1222945391262e3 --max-distance 1890.1422945391262e3 \
--l-distr fixed --longitude 85.59060668945312 --latitude -2.812037229537964 --i-distr uniform \
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
