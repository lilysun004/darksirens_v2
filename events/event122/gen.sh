lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.70798798798799 --fixed-mass2 80.86522522522523 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001874977.0785998 \
--gps-end-time 1001882177.0785998 \
--d-distr volume \
--min-distance 3679.4832019061428e3 --max-distance 3679.503201906143e3 \
--l-distr fixed --longitude 7.326460361480713 --latitude -64.40215301513672 --i-distr uniform \
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
