lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.23907907907908 --fixed-mass2 13.714034034034036 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015269110.5776088 \
--gps-end-time 1015276310.5776088 \
--d-distr volume \
--min-distance 1059.5179945335242e3 --max-distance 1059.5379945335242e3 \
--l-distr fixed --longitude 118.15292358398438 --latitude 50.40873336791992 --i-distr uniform \
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
