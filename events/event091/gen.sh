lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.88336336336336 --fixed-mass2 53.80304304304305 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015412500.9508191 \
--gps-end-time 1015419700.9508191 \
--d-distr volume \
--min-distance 2162.025007095255e3 --max-distance 2162.0450070952556e3 \
--l-distr fixed --longitude -4.22943115234375 --latitude 40.97322463989258 --i-distr uniform \
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
