lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.6202202202202205 --fixed-mass2 74.30978978978979 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016533630.6881183 \
--gps-end-time 1016540830.6881183 \
--d-distr volume \
--min-distance 323.7702192597691e3 --max-distance 323.79021925976906e3 \
--l-distr fixed --longitude -76.233154296875 --latitude 22.702966690063477 --i-distr uniform \
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
